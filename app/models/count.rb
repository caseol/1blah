class Count < ActiveRecord::Base
  belongs_to :button

  #-- Número de Publicações
  #SELECT users.nickname, count(buttons.user_id) as rank
  #FROM users
  #JOIN buttons ON (buttons.user_id = users.id)
  #GROUP BY users.id
  #ORDER BY rank DESC;

  #scope :by_products, lambda{|product| {
  #     :select=> "DISTINCT orders.*",
  #     :joins=> "JOIN users ON (users.id = orders.user_id) JOIN line_items ON (orders.id = line_items.order_id) JOIN variants ON (variants.id = line_items.variant_id) JOIN products ON (products.id = variants.product_id) JOIN products_taxons ON (products_taxons.product_id = products.id) JOIN users_taxons ON (users_taxons.taxon_id = products_taxons.taxon_id) ",
  #     :conditions=> "products_taxons.product_id=#{product.id} AND orders.payment_state IN ('paid')"
  #    }
  #  }



end
