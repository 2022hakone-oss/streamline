  def create
    @article = current_user.articles.build(article_params)
    tag_list = params[:article][:tag_ids].split(',')  #追記
    @article.image.attach(params[:article][:image])
    if @article.save
      @article.save_tags(tag_list)  #追記
      flash[:success] = "Article created!"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end
