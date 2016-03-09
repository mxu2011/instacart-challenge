class FunnelsController < ApplicationController
  def index
    @funnel = serialized_response

    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end

  def serialized_response
    hash = {}
    start_date = params[:start_date].try(:to_date) || Date.today
    end_date = params[:end_date].try(:to_date) || Date.today
    query = FunnelsQuery.new(start_date, end_date)
    results = query.results
    results.each do |res|
      monday = res["monday"]
      sunday = res["sunday"]
      key = [monday, sunday].join("-")
      hash[key] = {} if hash[key].nil?
      hash[key][object["workflow_state"]] = object["count"]
    end
    hash
  end

  def default_applicant_hash
    array = Applicant::WORKFLOW_STATES.reject do |x|
      x == "background_check_authorized"
    end
    Hash[array.map { |x| [x, 0] }]
  end
end
