require 'csv'
class Admin::UsersController < ApplicationController
  http_basic_authenticate_with :name => "yubieda", :password => "bgPassw0rd"
  
  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end


  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /admin/users/1
  # PUT /admin/users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
  
  def export
    column_names = User.first.attributes.keys.reject{|k| k =~ /password_digest|remember_token/}

    data = CSV.generate do |csv|
      csv << column_names
      User.all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end

    send_data(data, :filename => "boogif_users_#{Date.today.to_s(:db)}.csv", :type => 'text/csv', :disposition => 'inline')
  end
end
