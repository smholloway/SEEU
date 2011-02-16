class ModelsController < ApplicationController
  # GET /models
  # GET /models.xml
  def index
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @models = @manufacturer.models

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @models }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @model = @manufacturer.models.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/1/edit
  def edit
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @model = @manufacturer.models.find(params[:id])
  end

  # POST /models
  # POST /models.xml
  def create
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @model = @manufacturer.models.build(params[:model])

    respond_to do |format|
      if @model.save
        format.html { redirect_to manufacturer_model_path(@manufacturer, @model) }
        format.xml  { render :xml => @model, :status => :created, :location => @model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to manufacturer_model_path(@manufacturer, @model) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to manufacturer_models_path(@manufacturer) }
      format.xml  { head :ok }
    end
  end
end
