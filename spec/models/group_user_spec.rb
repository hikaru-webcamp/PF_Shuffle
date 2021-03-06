# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'グループユーザーモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(GroupUser.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Groupモデルとの関係' do
      it 'N:1となっている' do
        expect(GroupUser.reflect_on_association(:group).macro).to eq :belongs_to
      end
    end
  end
end
