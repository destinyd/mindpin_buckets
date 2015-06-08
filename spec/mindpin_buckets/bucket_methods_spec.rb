require 'spec_helper'

class Book
  include MindpinBuckets::BucketResourceMethods
  act_as_bucket_resource into: :folder
end

describe 'bucket_methods' do
  describe "single collect" do
    class Folder
      include MindpinBuckets::BucketMethods
      act_as_bucket collect: :book
    end

    let(:folder){Folder.create}

    it do
      folder.respond_to?(:books).should == true
    end

    it "#add_resource" do
      book = Book.create
      folder.add_resource(book).should == true
      # 重复添加返回 false
      folder.add_resource(book).should == false
    end
    
    it "#add_resources" do
      books = []
      book1 = Book.create
      books << book1
      books << Book.create
      folder.add_resources(books).should == true
      # 重复添加返回 false
      folder.add_resources([]).should == false
      folder.add_resources(Book.create).should == false
    end

    describe "add two book" do
      let(:book1) { Book.create}
      let(:book2) { Book.create}

      before do
        folder.add_resources [book1, book2]
      end

      it "#remove_resource" do
        folder.remove_resource(book1).should == true
        folder.remove_resource(book2).should == true
        folder.remove_resource(book2).should == false
      end

      it "#remove_resources wrong type" do
        folder.remove_resources(book1).should == false
        folder.remove_resources([]).should == false
        folder.remove_resources(nil).should == false
      end

      it "#remove_resources [book]" do
        folder.remove_resources([book1]).should == true
        folder.remove_resources([book2]).should == true
        folder.remove_resources([book2]).should == false
      end

      it "#remove_resources [books]" do
        folder.remove_resources([book1, book2]).should == true
        folder.remove_resources([book1, book2]).should == false
      end
    end
  end
end
