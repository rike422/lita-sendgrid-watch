require 'spec_helper'

describe StatusTopic do
  include_context 'variables'
  subject { StatusTopic }
  before { subject.create(url, title) }
  describe '.all' do
    it 'returns all urls' do
      expect(subject.all).to eq([url])
    end
  end
  describe '.create(url, title)' do
    it 'sets the key to url and the value to title' do
      subject.create(url, title)
      expect(subject.read(url)).to eq(title)
    end
  end
  describe '.read(url)' do
    it 'returns the title for the url' do
      expect(subject.read(url)).to eq(title)
    end
  end
  describe '.destroy(url)' do
    it 'destroys url' do
      subject.create(url, title)
      subject.destroy(url)
      expect(subject.read(url)).to be_nil
    end
  end
  describe '.exists?(url)' do
    it 'returns true if url exists' do
      expect(subject.exists?(url)).to be_truthy
    end
    it "returns false if url does not exist" do
      subject.destroy(url)
      expect(subject.exists?(url)).to be_falsey
    end
  end
end
