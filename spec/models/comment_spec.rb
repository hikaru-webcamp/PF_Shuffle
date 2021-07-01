# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do

    context 'bodyカラム' do
      it '空欄でないこと' do
        expect(build(:comment, body: "")).to be_invalid
      end
      it '200文字以下であること: 200文字はOK' do
        expect(build(:comment, body: Faker::Lorem.characters(number: 200) )).to be_valid
      end
      it '200文字以下であること: 201文字はNG' do
        expect(build(:comment, body: Faker::Lorem.characters(number: 201) )).to be_invalid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
