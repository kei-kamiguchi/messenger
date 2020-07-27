module BlogsHelper
  # def choose_new_or_edit
  #   if action_name == 'new' || action_name == 'create'
  #     confirm_blogs_path
  #   elsif action_name == 'edit'
  #     confirm_blog_path(@blog.id)
  #   end
  # end


  #　以下、編集にも確認画面を適用
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_blogs_path
    elsif action_name == 'edit' || action_name == 'update'
      confirm_blog_path(@blog.id)
    end
  end
  # 以下の2つのメソッドでルーティングを分岐している。
  # @blogにidがあれば「patch 'blog_path'」、idがなければ「post 'blogs_path'」
  def confirm_new_or_edit
    unless @blog.id?
      blogs_path
    else
      blog_path
    end
  end

  def confirm_form_method
    @blog.id ? 'patch' : 'post'
  end
end
