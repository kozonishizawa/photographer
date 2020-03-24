module ApplicationHelper
	def admin_menu
		[
			{
				name: '新規ユーザー登録',
				url: new_admin_user_path,
				description: 'ユーザーアカウントを作成します。',
			},
			{
				name: 'ユーザー管理',
				url: admin_users_path,
				description: 'ユーザー情報の編集やアルバムを作成することができます。',
			},
			{
				name: 'アルバム管理',
				url: admin_albums_path,
				description: 'アルバムに写真を登録することができます。',
			},
			{
				name: 'お問い合わせ',
				url: admin_contacts_path,
				description: 'お問い合わせを閲覧することができます。',
			}
		]
	end

	def user_menu
		[
			{ name: '写真の受け取りを開始する', url: front_albums_path},
		]
	end

	def full_title(page_title = '')

		"#{page_title.blank?? nil : page_title+' | '}BigDay_photograph"
	end

end
