module LocationHelper
  def city_to_slug(city)
    city.downcase.parameterize
  end

  def slug_to_city(city)
    city.gsub('-',' ').titleize
  end

  module_function :slug_to_city, :city_to_slug
end
