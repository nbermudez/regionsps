namespace :system do
  task :permissions => :environment do
    role = Role.find_by_name "Administrador"
    permissions = role.permissions
    permissionsIds = []
    permissions.each do |permission|
      permissionsIds.push(permission.id)
    end

    allpermi = Permission.where('id not in (?)', permissionsIds)
    allpermi.each do |permission|
      role.permissions.push(permission)
    end
    role.save
  end

  task :UpdateCategoriesPosition => :environment do
    categories = Category.all

    counter = 1
    categories.each do |category|
      category.position = counter
      category.save
      counter = counter + 1
    end
  end

  task :UpdateTagCategorizationPosition => :environment do
    categories = Category.all
    categories.each do |category|
      tagsCate = TagCategorization.where('category_id = (?)', category.id)
      counter = 0
      tagsCate.each do |tagCate|
        tagCate.tag_position = counter
        tagCate.save
        counter = counter + 1
      end
    end
  end

end