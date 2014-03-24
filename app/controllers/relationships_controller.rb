class RelationshipsController < ApplicationController

  def create
    @relationship = Relationship.new(params[:relationship])
    @legislator = Legislator.find(@relationship.legislator_id)
    # @relationship.legislator_id = legislator.id
    @relationship.user_id = current_user.id
    if @relationship.save
      flash[:notice] = "You are now following #{@legislator.title}"+" "+"#{@legislator.first_name}"+" "+"#{@legislator.last_name}"
      redirect_to root_path
    end
  end

  def destroy
    @relationship.destroy
  end
end