defmodule BlogsTest do
  use VcrCase
  alias Hypemex.Blogs

	describe "collection" do
		it "returns all blogs data" do
			use_cassette "blogs_collection" do
				first_blog_url =  Blogs.collection |> List.first |> Map.get("siteurl")
				last_blog_url  =  Blogs.collection |> List.last  |> Map.get("siteurl")

				assert first_blog_url == "http://www.okayplayer.com"
				assert last_blog_url == "http://mu-sique.com/"
			end
		end
	end

  describe "find" do
    it "finds a blog by its name" do
      use_cassette "find_blog_name" do
        followers = Blogs.find("okayplayer") |> Map.get("followers")
        assert followers == 1208
      end
    end

    it "finds a blog by its id" do
      use_cassette "find_blog_id" do
        followers = Blogs.find(16684) |> Map.get("followers")
        assert followers == 1208
      end
    end
  end

  describe "subcollection" do
    it "returns a blog data as a subcollection" do
      use_cassette "blog_tracks" do
        first_track = Blogs.find("okayplayer")
                      |> Blogs.subcollection("tracks")
                      |> List.first
        last_track = Blogs.find("okayplayer")
                      |> Blogs.subcollection("tracks")
                      |> List.last
        assert first_track["artist"] == "Kenneth Whalum"
        assert last_track["artist"] == "Blu & Fa†e"
      end
    end

    it "returns subset of data for an specific blog id" do
      use_cassette "blog_id_tracks" do
        last_track = Blogs.subcollection(16684, "tracks") |> List.last
        assert last_track["artist"], "Blu & Fa†e"
      end
    end
  end

  describe "obtain" do
    it "returns metadata from the blogs path" do
      assert Blogs.obtain("count") == 712
    end
  end
end
