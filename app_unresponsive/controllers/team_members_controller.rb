class TeamMembersController < ApplicationController
  def index
    @title = "Team Members"
    @search  = TeamMember.active.position.search(params[:search])
    @team_members = @search
    if params[:team_category] && TeamCategory.exists?(params[:team_category])
      @title << ": #{TeamCategory.find(params[:team_category]).name.titleize}"
      @team_members = @team_members.select{|x| x.team_category_ids.include?(params[:team_category].to_i)}
    else
      @team_members = @team_members.sort_by{|x| x.name.split(" ").last}
    end
    @team_members = @team_members.paginate(:page => params[:page], :per_page => 20)
  end  

  def show
    @team_member = TeamMember.find(params[:id])
    @related_team_members = []
    for team_category in @team_member.team_categories
      team_category.team_members.each{|x| @related_team_members << x}
    end
    @related_team_members = @related_team_members.uniq.reject{|x| x == @team_member}.sort_by{|x| x.position}
    @related_team_members =  @related_team_members.reject{|x| !x.team_category_ids.include?(params[:team_category].to_i) } if params[:team_category]
    @testimonial  = @team_member.testimonials.sort_by{rand}.first
    @testimonials = @team_member.testimonials.sort_by{rand}.reject{|t| t == @testimonial} unless @team_member.testimonials.blank? or not @team_member.testimonials.length > 1
  end
end
