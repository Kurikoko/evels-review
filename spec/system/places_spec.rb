require 'rails_helper'

RSpec.describe "会場登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "会場新規登録できる場合" do
    it "ログインしたユーザーは新規会場登録できる" do
      # ログインする
      sign_in(@user)
      # 会場登録ページへのボタンがあることを確認する
      expect(page).to have_content("会場登録")
      # 会場登録ページへ遷移する
      visit new_place_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像添付する
      attach_file('place[image]', image_path, make_visible:true)
      # 値をテキストフォームに入力する
      post_name ="test-name"
      post_text ="test-text"
      fill_in "place-name-input", with: post_name
      fill_in "place-text-input", with: post_text
      select '千代田区', from: 'place[area_id]'
      select '占有回線', from: 'place[line_kinds_id]'
      select 'あり', from: 'place[backup_line_id]'
      select '会場費に含む', from: 'place[fee_id]'
      select '有り', from: 'place[wifi_id]'
      # 送信するとPlaceモデルカウントが１つ上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Place.count}.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページに登録した内容が存在することを確認する(画像)
      expect(page).to have_selector('img')
      # トップページに登録した内容が存在することを確認する(テキスト)
      expect(page).to have_content(post_name)
      expect(page).to have_content(post_text)
    end
  end

  context '会場新規登録できない場合' do
    it '値が空では会場新規登録できない' do
      # ログインする
      sign_in(@user)
      # 会場登録ページへのボタンがあることを確認する
      expect(page).to have_content("会場登録")
      # 会場登録ページへ遷移する
      visit new_place_path
      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Place.count}.by(0)
      # 新規会場登録ページに戻される
      expect(current_path).to eq places_path
    end

    it 'ログインしていないと新規会場登録ページに遷移できない' do
      # ログインしていないと新規会場登録ページへの遷移ボタンが表示されない
      expect(page).to have_no_content("会場登録")
    end
  end
end
