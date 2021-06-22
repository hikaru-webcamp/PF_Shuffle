# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user)    { create(:user)                                            }
    let(:post)    { create(:post, user_id: user.id)                          }
    let(:comment) { create(:comment, user_id: user.id, post_id: post.id)     }

    context 'commentカラム' do
      it 'コメントが空では投稿できない' do
        comment.body = ''
        expect(comment).not_to be_valid
      end
      it '201文字以上ではコメントできない' do
        comment.body = Faker::Lorem.characters(number: 201)
        p comment
        expect(comment).not_to be_valid
      end
      it '200文字以内ではコメントできる' do
        comment.body = Faker::Lorem.characters(number: 200)
        expect(comment).to be_valid
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
