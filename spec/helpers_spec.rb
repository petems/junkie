describe Helpers do

  let(:pulls_ready) {
    {
      issue_comments: parsed_fixture_from('ready_issue_comments'),
      pull_comments: parsed_fixture_from('ready_pull_comments')
    }
  }

  let(:pulls_not_ready) {
    {
      issue_comments: parsed_fixture_from('not_ready_issue_comments'),
      pull_comments: parsed_fixture_from('not_ready_pull_comments')
    }
  }

  let(:session) {
    session = {
      user: "user",
      user_id: 666667
    }
  }

  context '#can_merge_it?' do
    it 'returns true if pull can be merged' do
      result = can_merge_it?(pulls_ready)

      expect(result).to be_truthy
    end

    it 'returns false if pull can not be merged' do
      result = can_merge_it?(pulls_not_ready)

      expect(result).to be_falsey
    end
  end

  context '#reviewed_it?' do
    it "returns false if you didn't reviewed yet" do
      result = reviewed_it?(pulls_not_ready)

      expect(result).to be_falsey
    end

    it "returns true if you reviewed it" do
      result = reviewed_it?(pulls_ready)

      expect(result).to be_truthy
    end
  end

  context '#comments?' do
    it "returns true if you commented it" do
      result = comments?(pulls_ready)

      expect(result).to be_truthy
    end

    it "returns false if you didn't commented it" do
      result = comments?(pulls_not_ready)

      expect(result).to be_falsey
    end
  end

  def parsed_fixture_from(file_name)
    file = File.open("spec/support/fixtures/#{file_name}.json", 'rb').read

    JSON.parse(file, symbolize_names: true)
  end

end
