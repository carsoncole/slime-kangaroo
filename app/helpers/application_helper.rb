module ApplicationHelper

  def nice_shorter_date(date) # Dec 12, 2020
    date.strftime('%b %d, %Y') unless date.nil?
  end

  def nice_date(date) # December 12, 2020
    date.strftime('%B %d, %Y') unless date.nil?
  end

  def nice_compact_date(date)
    date.strftime('%d-%b-%y') unless date.nil?
  end

  def nice_brief_date(date)
    date.strftime('%b-%d') unless date.nil?
  end

  def nice_datetime(date)
    date.strftime('%B %d, %Y %I:%M:%S %p %Z') unless date.nil?
  end

  def nice_datetime_concise(date)
    date.strftime('%b %d, %y %I:%M:%S %p %Z') unless date.nil?
  end

  def nice_datetime_compact(date)
    date.strftime('%m-%d-%y %I:%M:%S %p %Z') unless date.nil?
  end

  def local_time(date)
    date.in_time_zone("Pacific Time (US & Canada)")
  end


  def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
end
