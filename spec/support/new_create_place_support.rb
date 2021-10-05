module NewCreatePlaceSupport
  def new_create_place(place)
    visit new_place_path
    image_path = Rails.root.join('public/images/test_image.png')
    attach_file('place[image]', image_path, make_visible:true)

    fill_in "place-name-input", with: place.place_name
    fill_in "place-text-input", with: place.carrier
    select '千代田区', from: 'place[area_id]'
    select '占有回線', from: 'place[line_kinds_id]'
    select 'あり', from: 'place[backup_line_id]'
    select '会場費に含む', from: 'place[fee_id]'
    select '有り', from: 'place[wifi_id]'
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end