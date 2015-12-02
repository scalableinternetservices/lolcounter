class TeamcompController < ApplicationController
  def index
    expires_in 10.minutes, :public => true
    top_champ = params[:top]
    jungle_champ = params[:jungle]
    mid_champ = params[:mid]
    adc_champ = params[:adc]
    support_champ = params[:support]

    #puts "DEBUG: Inside teamcomp#index!"

    #Do any database access codes below
    @champion = Champion.all
    @games = Game.all
    @top_name = top_champ
    @jungle_name = jungle_champ
    @mid_name = mid_champ
    @adc_name = adc_champ
    @support_name = support_champ

    #    puts("hello")
    if(top_champ != nil && jungle_champ != nil && mid_champ != nil && adc_champ != nil && support_champ != nil)
      top_url_name = top_champ.gsub(/\s|"|'/, '');
      jungle_url_name = jungle_champ.gsub(/\s|"|'/, '');
      mid_url_name = mid_champ.gsub(/\s|"|'/, '');
      adc_url_name = adc_champ.gsub(/\s|"|'/, '');
      support_url_name = support_champ.gsub(/\s|"|'/, '');
      if(top_url_name == 'Wukong')
          top_url_name = 'MonkeyKing'
      end
      if(jungle_url_name == 'Wukong')
        jungle_url_name = 'MonkeyKing'
      end
      if(mid_url_name == 'Wukong')
        mid_url_name = 'MonkeyKing'
      end
      if(adc_url_name == 'Wukong')
        adc_url_name = 'MonkeyKing'
      end
      if(support_url_name == 'Wukong')
        support_url_name = 'MonkeyKing'
      end
      @top_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + top_url_name + '.png'
      @jungle_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + jungle_url_name + '.png'
      @mid_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + mid_url_name + '.png'
      @adc_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + adc_url_name + '.png'
      @support_icon = 'http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/' + support_url_name + '.png'
    else
      @valid = 'invalid';
    end

    if (top_champ == nil && jungle_champ == nil && mid_champ == nil && adc_champ == nil && support_champ == nil)
      @valid = 'empty';
    end

    @top = @champion.where(name:@top_name).pluck(:id)
    @jungle = @champion.where(name:@jungle_name).pluck(:id)
    @mid = @champion.where(name:@mid_name).pluck(:id)
    @adc = @champion.where(name:@adc_name).pluck(:id)
    @support = @champion.where(name:@support_name).pluck(:id)
    #if(@champion.where(name:@top_name).count == 1 && @champion.where(name:@jungle_name).count == 1 && @champion.where(name:@mid_name).count == 1 && @champion.where(name:@adc_name).count == 1 && @champion.where(name:@support_name).count == 1)
    if(!@top.blank? && !@jungle.blank? && !@mid.blank? && !@adc.blank? && !@support.blank?)
      @wins = @games.where(WIN_TOP:@top,WIN_JG:@jungle,WIN_MID:@mid,WIN_ADC:@adc,WIN_SUP:@support).count
      @losses = @games.where(LOSE_TOP:@top,LOSE_JG:@jungle,LOSE_MID:@mid,LOSE_ADC:@adc,LOSE_SUP:@support).count
      @num_games = 0.0
      @num_games = @wins + @losses
      if(@num_games > 0)
        @win_rate = @wins/(@num_games+0.0)
        if(@win_rate == 1.0)
          @win_rate = 1
        end
      else
        @win_rate = 0
      end
      @valid = 'valid'
    end
  end
end
