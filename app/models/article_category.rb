# == Schema Information
#
# Table name: article_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  category_id :integer
#

class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
