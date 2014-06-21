class Admin::GoalsController < ApplicationController

	def index
		@year = params[:year].to_i
		@user = params[:user].to_i
		@chapel = params[:chapel].to_i

		@goalsTemp = Goal.where("year = ? and chapel_id = ?", @year, @chapel)

		if @goalsTemp.size==0
			@typestadis = Typestadistic.all

			@typestadis.each do |td|
				goal = Goal.new
				goal.typestadistic_id = td.id
				goal.total = 0
				goal.year = @year
				goal.user_id = @user
				goal.chapel_id = @chapel
				goal.ableEditing = true
				goal.sentToStake = false
				goal.save
			end
		end

		@goals = Goal.where("year = ? and chapel_id = ?", @year, @chapel).order(:created_at)
		@sentStake = false

		if @goals.first.sentToStake==true
			@sentStake = true;
		end
	end

	def edit
		@goal = Goal.find(params[:id])
	end

	def update
		@goal = Goal.find(params[:id])
		
		if @goal.update_attributes(params[:goal])
			respond_to do |format|
			  format.html { redirect_to admin_goals_index_path(@goal.year,@goal.user_id,@goal.chapel_id) }
			  format.js
			end
		else
			redirect_to admin_goals_index_path(@goal.year,@goal.user_id,@goal.chapel_id), :flash => { :error => "***No se pudo guardar los cambios." }
		end
	end

	def sendToStake
		@year = params[:year].to_i
		@chapel = params[:chapel].to_i

		@goalsTemp = Goal.where("year = ? and chapel_id = ?", @year, @chapel)
		@goalsCompare = Goal.where("year = ? and chapel_id = ? and total = ?", @year, @chapel, 0)

		if @goalsCompare.size!=0
			redirect_to admin_goals_index_path(@year,@goalsTemp.first.user_id,@chapel), :flash => { :error => "***No puede dejar metas en 0." }
		else
			@goalsTemp.each do |g|
				goal = Goal.find(g.id)
				goal.sentToStake = true
				goal.ableEditing = false
				goal.save
			end

			redirect_to admin_stadistics_path
		end
	end
	
end
