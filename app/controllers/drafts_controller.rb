class DraftsController < ApplicationController
  before_filter :require_admin

  # GET /drafts
  # GET /drafts.xml
  def index
    @drafts = Draft.draft_order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @drafts }
    end
  end

  # GET /drafts/1
  # GET /drafts/1.xml
  def show
    @draft = Draft.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @draft }
    end
  end

  # GET /drafts/new
  # GET /drafts/new.xml
  def new
    @draft = Draft.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @draft }
    end
  end

  # GET /drafts/1/edit
  def edit
    @draft = Draft.find(params[:id])
  end

  # POST /drafts
  # POST /drafts.xml
  def create
    @draft = Draft.new(params[:draft])

    respond_to do |format|
      if @draft.save
        format.html { redirect_to(drafts_url, :notice => 'Draft was successfully created.') }
        format.xml  { render :xml => @draft, :status => :created, :location => @draft }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @draft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /drafts/1
  # PUT /drafts/1.xml
  def update
    @draft = Draft.find(params[:id])
    
    respond_to do |format|
      if @draft.update_attributes(params[:draft])
        Draft.start_draft_clock
        format.html { redirect_to(drafts_url, :notice => 'Draft was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @draft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /drafts/1
  # DELETE /drafts/1.xml
  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy

    respond_to do |format|
      format.html { redirect_to(drafts_url) }
      format.xml  { head :ok }
    end
  end

  def start_draft_clock
    Draft.start_draft_clock
    redirect_to(drafts_url)
  end

  def stop_draft_clock
    Draft.stop_draft_clock
    redirect_to(drafts_url)
  end
end
