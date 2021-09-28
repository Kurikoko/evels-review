module PlacesHelper
  def backup_line_bad(place)
    if place.backup_line_id == 3
      return 'bad_color'
    end
  end

  def line_kinds_bad(place)
    if place.line_kinds_id == 3
      return 'bad_color'
    end
  end

  def wifi_bad(place)
    if place.wifi_id == 3
      return 'bad_color'
    end
  end
end
