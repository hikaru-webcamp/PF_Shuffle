# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # テスト対象の記述を1箇所にまとめる
    subject { user.valid? }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字はNG' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字はOK' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字はOK' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字はNG' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '160文字以下であること: 160文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 160)
        is_expected.to eq true
      end
      it '160文字以下であること: 161文字は×' do
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
