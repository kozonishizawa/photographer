module ApplicationHelper
	def admin_menu
		[
			{ name: 'ユーザー管理', url: admin_users_path},
			{ name: '写真管理', url: admin_photos_path},
			{ name: '記事管理', url: admin_articles_path},
			{ name: 'チャット', url: admin_rooms_path}, 
			{ name: 'お問い合わせ', url: admin_contacts_path}
		]
	end

	def full_title(page_title = '')

		"#{page_title.blank?? nil : page_title+' | '}BigDay_photograph"
	end

end
