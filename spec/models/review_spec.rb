require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @place = FactoryBot.create(:place)
    @review = FactoryBot.build(:review, user_id: @user.id, place_id: @place.id)
    sleep(0.1)
  end

  describe 'ユーザーがレビュー' do
    context 'レビューできる場合' do
      it '全ての値が正しく入力されていればレ保存できる' do
        expect(@review).to be_valid
      end
      it '画像が空でも保存できる' do
        @review.image = nil
        expect(@review).to be_valid
      end
    end

    context 'レビューできない場合' do
      it 'downloadが空では保存できない' do
        @review.download = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('DOWNLOAD SPEED が入力されていません')
      end
      it 'downloadが半角数値でなければ保存できない' do
        @review.download = '１０００'
        @review.valid?
        expect(@review.errors.full_messages).to include('DOWNLOAD SPEED は半角数値で入力ください')
      end
      it 'downloadが0.01以下では保存できない' do
        @review.download = 0.001
        @review.valid?
        expect(@review.errors.full_messages).to include('DOWNLOAD SPEED は0.01から3000の範囲で入力ください')
      end
      it 'downloadが0.01以下では保存できない' do
        @review.download = 3000.1
        @review.valid?
        expect(@review.errors.full_messages).to include('DOWNLOAD SPEED は0.01から3000の範囲で入力ください')
      end

      it 'uploadが空では保存できない' do
        @review.upload = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('UPLOAD SPEED が入力されていません')
      end
      it 'downloadが半角数値でなければ保存できない' do
        @review.upload = '１０００'
        @review.valid?
        expect(@review.errors.full_messages).to include('UPLOAD SPEED は半角数値で入力ください')
      end
      it 'downloadが0.01以下では保存できない' do
        @review.upload = 0.001
        @review.valid?
        expect(@review.errors.full_messages).to include('UPLOAD SPEED は0.01から3000の範囲で入力ください')
      end
      it 'downloadが0.01以下では保存できない' do
        @review.upload = 3000.1
        @review.valid?
        expect(@review.errors.full_messages).to include('UPLOAD SPEED は0.01から3000の範囲で入力ください')
      end

      it 'コメントが空では保存できない' do
        @review.comment = ''
        @review.valid?
        expect(@review.errors.full_messages).to include('コメント が入力されていません')
      end

      it 'placeが紐付いていなければ保存できない' do
        @review.place_id = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('会場 が紐付いていません')
      end
      it 'userが紐付いていなければ保存できない' do
        @review.user_id = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('ユーザー が紐付いていません')
      end
      it '1人のuserは1つのplaceに複数レビューできない' do
        @review.save
        another_review = FactoryBot.build(:review, user_id: @review.user_id, place_id: @place.id)
        another_review.valid?
        expect(another_review.errors.full_messages).to include('会場 のレビューが既に登録されています')
      end
    end
  end
end
