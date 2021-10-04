module PlacesHelper
  def backup_line_bad(place)
    if place.backup_line_id == 3 || place.backup_line_id == 4
      return 'bad_color'
    end
  end

  def line_kinds_bad(place)
    if place.line_kinds_id == 3 || place.line_kinds_id == 4
      return 'bad_color'
    end
  end

  def wifi_bad(place)
    if place.wifi_id == 3 || place.wifi_id == 4
      return 'bad_color'
    end
  end

  def fee_bad(place)
    if place.fee_id == 4
      return 'bad_color'
    end
  end
end
