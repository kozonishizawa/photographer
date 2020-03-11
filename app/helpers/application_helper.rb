module ApplicationHelper
	def admin_menu
		[
			{ name: '新規ユーザー登録', url: new_admin_user_path},
			{ name: 'ユーザー管理', url: admin_users_path},
			{ name: 'アルバム管理', url: admin_albums_path},
			{ name: 'お問い合わせ', url: admin_contacts_path}
		]
	end

	def user_menu
		[
			{ name: '利用者情報', url: front_user_path(current_user.id)},
			{ name: 'アルバム', url: front_albums_path},
			{ name: '撮影依頼', url: new_front_contact_path},
		]
	end

	def full_title(page_title = '')

		"#{page_title.blank?? nil : page_title+' | '}BigDay_photograph"
	end

end
