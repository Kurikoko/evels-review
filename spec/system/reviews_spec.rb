require 'rails_helper'

RSpec.describe 'レビュー投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @place = FactoryBot.create(:place)
    @review = FactoryBot.build(:review, user_id: @user.id, place_id: @place.id)
  end

  context 'レビューできる場合' do
    it 'ログインしたユーザーはレビューできる' do
      # ログインする
      sign_in(@user)
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      # 会場詳細ページに遷移したことを確認する
      expect(current_path).to eq(place_path(@place.id))
      # 会場詳細ページにレビューするボタンがあることを確認する
      expect(page).to have_link 'レビューする', href: new_place_review_path(@place)
      # レビューページへ遷移する
      visit new_place_review_path(@place.id)
      # レビューフォームへ入力する
      fill_in 'download-speed', with: @review.download
      fill_in 'upload-speed', with: @review.upload
      fill_in 'comment', with: @review.comment
      # レビューボタンを押すと、Reviewモデルカウントが１つ上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Review.count }.by(1)
      # 会場詳細ページに遷移したことを確認する
      expect(current_path).to eq(place_path(@place.id))
      # 会場詳細ページにレビューした内容があることを確認する(テキスト)
      expect(page).to have_content(@review.comment.to_s)
    end
  end

  context 'レビューできない場合' do
    it 'ログインしていないユーザーはレビューできない' do
      # トップページに遷移する
      visit root_path
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      # 会場詳細ページに遷移したことを確認する
      expect(current_path).to eq(place_path(@place.id))
      # 会場詳細ページにレビューするボタンがあることを確認する
      expect(page).to have_link 'レビューする', href: new_place_review_path(@place)
      # レビューページへ遷移する
      visit new_place_review_path(@place.id)
      # ログインページに遷移したことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'レビュー編集', type: :system do
  before do
    @place = FactoryBot.create(:place)
    @review1 = FactoryBot.create(:review, place_id: @place.id)
    @review2 = FactoryBot.create(:review, place_id: @place.id)
  end

  context 'レビュー編集できる場合' do
    it 'ログインしたユーザーは自分が投稿したレビューの編集ができる' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @review1.user.email
      fill_in 'user_password', with: @review1.user.password
      find('input[name="commit"]').click
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_place_review_path(@place.id, @review1.id)
      # レビュー1の「編集」ページに遷移する
      visit edit_place_review_path(@place.id, @review1.id)
      # すでにレビュー済みの内容がフォームに入っていることを確認する
      expect(
        find('#download-speed').value.to_f
      ).to eq(@review1.download.round(2))
      expect(
        find('#upload-speed').value.to_f
      ).to eq(@review1.upload.round(2))
      expect(
        find('#comment').value
      ).to eq(@review1.comment)
      # 投稿内容を変更する
      redownload = 100
      reupload = 1000
      recomment = 'test'
      fill_in 'download-speed', with: redownload
      fill_in 'upload-speed', with: reupload
      fill_in 'comment', with: recomment
      # レビューボタンを押すと、Reviewモデルカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Review.count }.by(0)
      # 会場詳細ページに遷移したことを確認する
      expect(current_path).to eq(place_path(@place.id))
    end
  end

  context 'レビュー編集できない場合' do
    it 'ログインしたユーザーは自分以外が投稿したレビューの編集はできない' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @review1.user.email
      fill_in 'user_password', with: @review1.user.password
      find('input[name="commit"]').click
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_place_review_path(@place.id, @review2.id)
    end
    it 'ログインしていないユーザーはレビュー編集できない' do
      # トップページに遷移する
      visit root_path
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_place_review_path(@place.id, @review1.id)
    end
  end
end

RSpec.describe 'レビュー削除', type: :system do
  before do
    @place = FactoryBot.create(:place)
    @review1 = FactoryBot.create(:review, place_id: @place.id)
    @review2 = FactoryBot.create(:review, place_id: @place.id)
  end

  context 'レビュー削除できる場合' do
    it 'ログインしたユーザーは自分が投稿したレビューの削除ができる' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @review1.user.email
      fill_in 'user_password', with: @review1.user.password
      find('input[name="commit"]').click
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー1に「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: place_review_path(@place.id, @review1.id)
      # レビュー1の「削除」ボタンをクリックするとReviewモデルカウントが-1になることを確認する
      click_link('削除', href: place_review_path(@place.id, @review1.id))
      expect do
        expect(page.accept_confirm).to eq('削除しますか?')
        sleep(0.5)
      end.to change { Review.count }.by(-1)
    end
  end

  context 'レビュー削除できない場合' do
    it 'ログインしたユーザーは自分以外が投稿したレビューの削除できない' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @review1.user.email
      fill_in 'user_password', with: @review1.user.password
      find('input[name="commit"]').click
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: place_review_path(@place.id, @review2.id)
    end
    it 'ログインしていないユーザーはレビュー削除できない' do
      # トップページに遷移する
      visit root_path
      # 登録した会場のタイトルをクリックして詳細ページへ遷移する
      click_link(@place.place_name.to_s)
      expect(current_path).to eq(place_path(@place.id))
      # レビュー1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: place_review_path(@place.id, @review1.id)
    end
  end
end
