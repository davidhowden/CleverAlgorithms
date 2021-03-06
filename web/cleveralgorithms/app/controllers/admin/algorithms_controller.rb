class Admin::AlgorithmsController < Admin::AdminController
  
  # GET /algorithms
  # GET /algorithms.xml
  def index
    @algorithms = Algorithm.ordered_by_name

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @algorithms }
    end
  end

  # GET /algorithms/1
  # GET /algorithms/1.xml
  # def show
  #   @algorithm = Algorithm.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @algorithm }
  #   end
  # end

  # GET /algorithms/new
  # GET /algorithms/new.xml
  def new
    @algorithm = Algorithm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @algorithm }
    end
  end

  # GET /algorithms/1/edit
  def edit
    @algorithm = Algorithm.first_by_name(params[:id])
  end

  # POST /algorithms
  # POST /algorithms.xml
  def create
    @algorithm = Algorithm.new(params[:algorithm])
    # @algorithm.id = nil

    respond_to do |format|
      if @algorithm.save!
        flash[:notice] = "Algorithm '#{@algorithm.name}' was successfully created."
        format.html { redirect_to(admin_algorithms_url) }
        # format.xml  { render :xml => @algorithm, :status => :created, :location => @algorithm }
      else
        format.html { render :action => "new" }
        # format.xml  { render :xml => @algorithm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /algorithms/1
  # PUT /algorithms/1.xml
  def update
    @algorithm = Algorithm.first_by_name(params[:id])

    respond_to do |format|
      if @algorithm.update_attributes(params[:algorithm])
        flash[:notice] = "Algorithm '#{@algorithm.name}' was successfully updated."
        format.html { redirect_to(admin_algorithms_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @algorithm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /algorithms/1
  # DELETE /algorithms/1.xml
  def destroy
    @algorithm = Algorithm.first_by_name(params[:id])
    @algorithm.destroy

    respond_to do |format|
      flash[:notice] = "Algorithm '#{@algorithm.name}' was successfully deleted."
      format.html { redirect_to(:action=>"index") }
      format.xml  { head :ok }
    end
  end
  
end
