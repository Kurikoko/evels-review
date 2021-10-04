require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do
      it "名前、メール、パスワード、確認用パスワードが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "パスワードが6文字以上で英数字を含んでいれば登録できる" do
        @user.password = "aaa111"
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "名前が空では登録できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前 が入力されていません")
      end
      it "メールが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレス が入力されていません")
      end
      it "メールに@を含んでいないと登録できない" do
        @user.email = "aaa.aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレス は有効でありません")
      end
      it "重複したメールアドレスは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレス は既に使用されています")
      end
      it "パスワードが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード が入力されていません")
      end
      it "パスワードが5文字以下では登録できない" do
        @user.password = "aa111"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード は6文字以上に設定して下さい")
      end
      it "パスワードが英語のみでは登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード は英数字を含んだ形にしてください")
      end
      it "パスワードが数字のみでは登録できない" do
        @user.password = "111111"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード は英数字を含んだ形にしてください")
      end
      it "パスワードと確認用パスワードが不一致では登録できない" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa112"
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワード があっていません")
      end

    end

  end

end
