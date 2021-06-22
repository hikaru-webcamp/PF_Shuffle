# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # テスト対象の記述を1箇所にまとめる
    subject { user.valid? }
     let!(:other_user) { create(:user) }
     let(:user) { build(:user)  }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
        # expect(user).not_to be_validの省略
      end
      it '2文字以下はNG' do
        user.name =  Faker::Name.name(number: 2)
        is_expected.to eq true
      end
      it '21文字以上はNG' do
        user.name =  Faker::Name.name(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
      it '正規表記でしか登録できないこと' do
        user.email = 'user@example,com'
        expect(user).not_to be_valid

        user.email = 'user_at_foo.org'
        expect(user).not_to be_valid

        user.email = 'user.name@example.'
        expect(user).not_to be_valid

        user.email = 'foo@bar_baz.com'
        expect(user).not_to be_valid

        user.email = 'foo@bar+baz.com'
        expect(user).not_to be_valid
      end
    end

    context 'introductionカラム' do
      it '161文字以上はNG' do
        user.introduction = Faker::Lorem.characters(number: 161)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'グループモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:groups).macro).to eq :has_many
      end
    end

    context 'グループユーザーモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:group_users).macro).to eq :has_many
      end
    end
  end
end
