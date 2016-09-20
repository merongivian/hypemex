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

  describe "subcollection" do
    it "returns a blog data as a subcollection" do
      use_cassette "blog_tracks" do
        first_track = Blogs.subcollection(16684, "tracks") |> List.first
        last_track = Blogs.subcollection(16684, "tracks") |> List.last

        assert first_track["artist"] == "YG feat. Drake"
        assert last_track["artist"] == "IAMNOBODI"
      end
    end
  end

  describe "obtain" do
    it "finds a blog by its id" do
      use_cassette "find_blog_id" do
        followers = Blogs.obtain(16684) |> Map.get("followers")
        assert followers == 1208
      end
    end

    it "returns metadata from the blogs path" do
      use_cassette "blogs_metadata" do
        assert Blogs.obtain("count") == 682
      end
    end
  end
end
