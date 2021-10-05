require 'rails_helper'

RSpec.describe Place, type: :model do
  before do
    @place = FactoryBot.build(:place)
  end

  describe '会場の新規登録' do
    context '会場の新規登録できる場合' do
      it '会場名、画像添付、回線サービス名が存在し、場所・回線種別・予備回線の有無・費用形態・Wifiが選択されていれば登録できる' do
        expect(@place).to be_valid
      end
    end

    context '会場の新規登録できない場合' do
      it '会場名が空では登録できない' do
        @place.place_name = ''
        @place.valid?
        expect(@place.errors.full_messages).to include('会場名 が入力されていません')
      end
      it '重複した会場名は登録できない' do
        @place.save
        another_place = FactoryBot.build(:place)
        another_place.place_name = @place.place_name
        another_place.valid?
        expect(another_place.errors.full_messages).to include('会場名 は既に登録されています')
      end
      it '画像が空では登録できない' do
        @place.image = nil
        @place.valid?
        expect(@place.errors.full_messages).to include('会場画像 を選択してください')
      end
      it '回線サービスが空では登録できない' do
        @place.carrier = ''
        @place.valid?
        expect(@place.errors.full_messages).to include('回線サービス が入力されていません')
      end
      it '場所が「---」では登録できない' do
        @place.area_id = 1
        @place.valid?
        expect(@place.errors.full_messages).to include('会場の場所 が選択されていません')
      end
      it '回線種別が「---」では登録できない' do
        @place.line_kinds_id = 1
        @place.valid?
        expect(@place.errors.full_messages).to include('回線の種別 が選択されていません')
      end
      it '費用形態が「---」では登録できない' do
        @place.fee_id = 1
        @place.valid?
        expect(@place.errors.full_messages).to include('費用形態 が選択されていません')
      end
      it '予備回線の有無が「---」では登録できない' do
        @place.backup_line_id = 1
        @place.valid?
        expect(@place.errors.full_messages).to include('予備回線の有無 が選択されていません')
      end
      it 'Wifiが「---」では登録できない' do
        @place.wifi_id = 1
        @place.valid?
        expect(@place.errors.full_messages).to include('Wifiの有無 が選択されていません')
      end
    end
  end
end
