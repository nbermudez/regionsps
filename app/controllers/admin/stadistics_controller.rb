class Admin::StadisticsController < ApplicationController

	def index

		@user = User.find(current_user.id)

		@roles = nil

		if @user.roles.any?
			@roles = @user.roles
		else
			redirect_to root_path, :notice => 'No tiene roles asignados a su cuenta.'
		end

		@typestads = Typestadistic.all

		@months = Hash.new

		for i in 1..Date.today.month
			case i
			when 1
				@months[1] = "Enero"
			when 2
				@months[2] = "Febrero"
			when 3
				@months[3] = "Marzo"
			when 4
				@months[4] = "Abril"
			when 5
				@months[5] = "Mayo"
			when 6
				@months[6] = "Junio"
			when 7
				@months[7] = "Julio"
			when 8
				@months[8] = "Agosto"
			when 9
				@months[9] = "Septiembre"
			when 10
				@months[10] = "Octubre"
			when 11
				@months[11] = "Noviembre"
			else
				@months[12] = "Diciembre"
			end
		end

		@chapel = nil

		if @roles != nil
			@chapel = Chapel.find(@user.chapel_id)
		else
			@chapel = Chapel.all.first
		end

		@stake = Stake.find(@chapel.stake_id)
		@year = Date.today.year

		@chapels = Chapel.where("stake_id = ?",@stake.id)

		@goals = Goal.where("year = ? and chapel_id = ?", @year, @chapel.id)

		if @roles != nil
			if @roles.where("name = ?","Secretario de Barrio").any?
				if @goals.size!=0 || @goals.first.sentToStake==false
					  redirect_to admin_goals_index_path(@year,@user.id,@chapel.id), :flash => { :error => "***Se encontraron ciertos problemas sin resolver." }
				end
			end
		end

		@pastStadistics = Stadistic.where("year < ? and chapel_id = ?", DateTime.now.year, @chapel.id)

		if @roles != nil
			if @roles.where("name = ?","Presidente de Estaca").any? || @roles.where("name = ?","Secretario de Estaca").any?
				respond_to do |format|
					format.html
					format.xls
				end
			end
    end

	end

	def new
		@stadistic = Stadistic.new
	end

	def create
		@stadistic = Stadistic.new(params[:stadistic])
		@stadistic.uploadstad = DateTime.now

		if @stadistic.save
			redirect_to stadistic_path(@stadistic.id)
		else
			render 'new'
		end
	end

	def edit
		@stadistic = Stadistic.find(params[:id])
	end

	def update
		@stadistic = Stadistic.find(params[:id])

		if @stadistic.update_attributes(params[:stadistic])
			redirect_to stadistic_m_path(@stadistic.month, @stadistic.year, @stadistic.chapel_id)
		else
			render 'edit'
		end
	end

	def month
		@month = params[:month].to_i

		@monthText = ""

		case @month
		when 1
			@monthText = "Enero"
		when 2
			@monthText = "Febrero"
		when 3
			@monthText = "Marzo"
		when 4
			@monthText = "Abril"
		when 5
			@monthText = "Mayo"
		when 6
			@monthText = "Junio"
		when 7
			@monthText = "Julio"
		when 8
			@monthText = "Agosto"
		when 9
			@monthText = "Septiembre"
		when 10
			@monthText = "Octubre"
		when 11
			@monthText = "Noviembre"
		else
			@monthText = "Diciembre"
		end

		@year = params[:year].to_i
		@user = User.find(params[:user].to_i)

		@roles = nil

		if @user.roles.any?
			@roles = @user.roles
		else
			redirect_to root_path, :notice => 'No tiene roles asignados a su cuenta.'
		end

		@stake = Stake.find(params[:stake].to_i)
		@chapel = nil

		if params[:chapel].to_i!=0
			@chapel = Chapel.find(params[:chapel].to_i)
		else
			@chapel = Chapel.where("stake_id = ?", @stake.id).first
		end

		@stad = Stadistic.where("month = ? and year = ? and chapel_id = ?", @month, @year, @chapel.id)

		if @stad.size==0
			if @month<=DateTime.now.month
				if @user.roles.where("name = ?","Secretario de Barrio").any? || @user.roles.where("name = ?","Secretario de Estaca").any?
					@typestadis = Typestadistic.all

					@typestadis.each do |td|
						stadis = Stadistic.new
						stadis.month = @month
						stadis.year = @year
						stadis.typestadistic_id = td.id
						stadis.total = 0
						stadis.user_id = @user.id
						stadis.chapel_id = @chapel.id
						stadis.save
					end
				end
			else
				redirect_to stadistics_path
			end
		end

		@stadistics = Stadistic.where("month = ? and year = ? and chapel_id = ?", @month, @year, @chapel.id).order("id ASC")
	end

	def lastyears
		@chapel = params[:chapel].to_i
		@stake = Stake.find(params[:stake].to_i)
		@user = User.find(params[:user].to_i)
		@year = params[:year].to_i
		@typestads = Typestadistic.all
		@chapels = Chapel.where("stake_id = ?",@stake.id)

		@months = Hash.new
		@months[1] = "Enero"
		@months[2] = "Febrero"
		@months[3] = "Marzo"
		@months[4] = "Abril"
		@months[5] = "Mayo"
		@months[6] = "Junio"
		@months[7] = "Julio"
		@months[8] = "Agosto"
		@months[9] = "Septiembre"
		@months[10] = "Octubre"
		@months[11] = "Noviembre"
		@months[12] = "Diciembre"

		@years = Hash.new

		if @chapel == 0
			@chapel = @chapels.first.id
		end
		
		stadpast = Stadistic.where("year < ? and chapel_id = ?", Date.today.year, @chapel)
		@years = Hash.new
		counter = 1
		stadpast.each do |sp|
			if @years.has_key?(sp.created_at.year) == false
				@years[counter] = sp.created_at.year
				counter = counter + 1
			end
		end
	end

	def export
		@stadistics = Stadistic.where("year = ?", @year)
	end

end
