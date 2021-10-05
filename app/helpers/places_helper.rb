module PlacesHelper
  def backup_line_bad(place)
    return 'bad_color' if place.backup_line_id == 3 || place.backup_line_id == 4
  end

  def line_kinds_bad(place)
    return 'bad_color' if place.line_kinds_id == 3 || place.line_kinds_id == 4
  end

  def wifi_bad(place)
    return 'bad_color' if place.wifi_id == 3 || place.wifi_id == 4
  end

  def fee_bad(place)
    return 'bad_color' if place.fee_id == 4
  end
end
