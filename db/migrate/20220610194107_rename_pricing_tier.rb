class RenamePricingTier < ActiveRecord::Migration[7.0]
  def change
    rename_column :camp_dues, :price_tier, :pricing_tier
    rename_column :camp_deposits, :price_tier, :pricing_tier
  end
end
