require 'spec_helper'

feature 'after entering a move' do
  describe 'move route' do
    it 'adds the correct player move to the session' do
      visit_root_and_enter_name
      enter_move('rock')

      expect(page.get_rack_session_key('player_move')).to eq('rock')
    end

    it 'adds the correct robot move to the session' do
      visit_root_and_enter_name
      enter_move('paper')

      expect([:rock, :paper, :scissors])
      .to include(page.get_rack_session_key('robot_move'))
    end

    it 'creates a session variable for the winner' do
      visit_root_and_enter_name
      enter_move('scissors')

      player = page.get_rack_session_key('player')

      expect(page.get_rack_session_key('winner')).to_not eq(nil)
      expect([
        player, 'Nobody', 'Robot'
          ]).to include(page.get_rack_session_key('winner'))
    end

    it 'adds the correct winner to the session' do
      visit_root_and_enter_name
      enter_move('rock')

      player = page.get_rack_session_key('player')
      player_move = page.get_rack_session_key('player_move')
      robot_move = page.get_rack_session_key('robot_move')
      parse = { -1 => player, 1 => 'Robot', 0 => 'Nobody' }
      result = Game.judge(player_move, robot_move)

      expect(page.get_rack_session_key('winner')).to eq(parse[result])
    end
  end
end