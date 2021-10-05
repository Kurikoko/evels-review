require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context "新規登録できる場合" do
    it "正しい情報を入力すればユーザー新規登録ができてトップページに移動する" do
      # トップページに遷移する
      visit root_path
      # ヘッダーにサインアップページへ遷移するボタンがある
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password
      # サインアップボタンを押すとユーザーモデルのカウントが１上がる
      expect {
        find('input[name="commit"]').click
      }.to change{User.count}.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにログアウトするボタンが表示される
      expect(page).to have_content("ログアウト")
      # ヘッダーに新規登録ボタンとログインボタンが表示されない
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context "新規登録できない場合" do
    it "誤った情報ではユーザーが新規登録できずに新規登録ページに戻ってくる" do
      # トップページに遷移する
      visit root_path
      # ヘッダーにサインアップページへ遷移するボタンがある
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      ## サインアップボタンを押してもユーザーモデルのカウントが上がらない
      expect {
        find('input[name="commit"]').click
      }.to change{User.count}.by(0)
      # 新規登録ページに戻される
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインできる場合'
    it '保存されているユーザー情報と合致すればログインできる' do
      # トップページに移動する
      visit root_path
      # ヘッダーにログインページに遷移できるボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページに遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにログアウトボタンがあることを確認する
      expect(page).to have_content("ログアウト")
      # 新規登録ページ・ログインページに遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ログインできない場合' do
    it '保存されてユーザー情報と合致しなければログインできない'do
    # トップページに移動する
    visit root_path
    # ヘッダーにログインページに遷移できるボタンがあることを確認する
    expect(page).to have_content("ログイン")
    # ログインページに遷移する
    visit new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: ""
    fill_in 'user_password', with: ""
    # ログインボタンを押す
    find('input[name="commit"]').click
    # ログインページに戻されることを確認する
    expect(current_path).to eq(user_session_path)
    end
  end
end