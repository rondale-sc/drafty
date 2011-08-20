class AdminController < ApplicationController
  before_filter :require_admin

  def index
  end

  def start_draft_clock
    Draft.start_draft_clock

    redirect_to admin_path
  end

  def stop_draft_clock
    Draft.stop_draft_clock

    redirect_to admin_path
  end
end
