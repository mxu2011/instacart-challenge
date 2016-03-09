class FunnelsQuery
  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def results
    ActiveRecord::Base.connection.execute(query)
  end

  private

  def week_start
    "DATE_TRUNC('week', created_at)::date"
  end

  def week_end
    "(#{week_start} + '6 days'::interval)::date"
  end

  def date_to_string(d)
    d.strftime("%Y-%m-%d")
  end

  def ranges
    st = @start_date.beginning_of_week
    en = @end_date.end_of_week
    (st..en).step(7).each_with_object([]) do |date, array|
      array << [date.beginning_of_week, date.end_of_week]
    end
  end

  def cases
    whens = []
    ranges.each_with_index do |arr, ind|
      whens << %{
        WHEN created_at >= '#{date_string array[0]}'
         AND created_at < '#{date_string array[1] + 1.day}' THEN #{index + 1}
      }
    end
    %{
      CASE
      #{whens.join(" ")}
      END
    }
  end

  def query
  %{
      SELECT
        #{week_start} AS monday, #{week_end} AS sunday, workflow_state, COUNT(*) as count, #{cases}
      FROM Applicants
      WHERE created_at >= '#{date_string start_date}'
        AND created_at <= '#{date_string end_date}'
      GROUP BY
        #{week_start}, #{week_end}, workflow_state, #{cases}
      ;
    }
  end
end
