defmodule ArtistsTest do
  use VcrCase
  alias Hypemex.Endpoints.Artists

  describe "collection" do
    it "returns all artists data" do
      use_cassette "artists#collection" do
        first_blog_url =  Artists.collection |> List.first |> Map.get("artist")
        last_blog_url  =  Artists.collection |> List.last  |> Map.get("artist")

        assert first_blog_url == "nxworries"
        assert last_blog_url == "seekae"
      end
    end
  end

  describe "subcollection" do
    it "returns an artists data as a subcollection" do
      use_cassette "artists#subcollection" do
        first_track = Artists.subcollection("nxworries", "tracks") |> List.first
        last_track = Artists.subcollection("nxworries", "tracks") |> List.last

        assert first_track["title"] == "Anderson Paak & Knxwledge - Link Up"
        assert last_track["title"] == "Anderson Paak & Knxwledge - Link Up (Beats 1 Radio Rip)"
      end
    end
  end

  describe "obtain" do
    it "finds a track by its id" do
      use_cassette "artists#obtain" do
        thumb = Artists.obtain("nxworries") |> Map.get("thumb_url_artist")
        assert thumb == "http://static-ak.hypem.net/resizer/thumbs_orig/71/3012209.jpg"
      end
    end
  end
end
