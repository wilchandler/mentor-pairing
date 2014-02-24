class MetricsController < ApplicationController
  def weekly
    @metrics = WeeklyMetricsPresenter.new(params[:for])
  end
end