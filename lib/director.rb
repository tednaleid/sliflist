class Director

  def self.write_dim_wishlist(filename)
    wishlist = Banshee44.roll_store.map{|r| AsherMir.new(r).generate_wishlist }.join("\n")
    File.write(filename, wishlist)
  end

end