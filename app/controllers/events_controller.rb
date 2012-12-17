class EventsController < ApplicationController
  before_filter :redirect_if_not_signed_in
  before_filter :redirect_if_no_event_name, only: [:create, :update]
  

  def new 
    @event = Event.new    
  end
  
  def create
    @event = Event.new(params[:event])
    @event.owner = current_user
    @event.save
    redirect_to events_path
  end
  
  def update
    @event = Event.find_by_id(params[:id])
    @event.invitees = getNewInvitees
    
    if @event.owner == current_user && 
        @event.update_attributes(params[:event])
      #getNewInvitees.map {|i| i.save}
      flash[:success] = "Event updated"
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if @event && @event.owner == current_user
      @event.destroy
    end
    redirect_to events_path
  end
  
  def index 
    @event = Event.new
  end  

  def show
    @event = Event.find_by_id(params[:id])
  end

  private
  
  def getNewInvitees
    invitees = []
    inviteIds = params[:user_ids]
    if inviteIds
      inviteIds.each do |i|
        invitees.push( Invitee.new(event_id: @event.id,user_id: i))
      end
    end
    
    invitees
  end

  def redirect_if_no_event_name
    if params[:id] 
      @event = Event.find_by_id(params[:id])
    else
      @event = Event.new(params[:event])
    end

    if !@event || !@event.name || @event.name.length == 0  
      flash[:error] = "You haven't created a name for the event"
      redirect_to request.referer
    end
  end


end
