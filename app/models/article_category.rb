# frozen_string_literal: true

# == Schema Information
#
# Table name: article_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  category_id :integer
#

# Joins table storing the references between articles and their categories
class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
