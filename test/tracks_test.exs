defmodule TracksTest do
  use VcrCase
  alias Hypemex.Endpoints.Tracks

  describe "collection" do
    it "returns all tracks data" do
      use_cassette "tracks#collection" do
        first_blog_url =  Tracks.collection |> List.first |> Map.get("title")
        last_blog_url  =  Tracks.collection |> List.last  |> Map.get("title")

        assert first_blog_url == "Far Away From A Distance"
        assert last_blog_url == "Shuffle"
      end
    end

    it "returns popular tracks data" do
      use_cassette "tracks#collection#popular" do
        first_blog_url =  Tracks.collection("popular") |> List.first |> Map.get("title")
        last_blog_url  =  Tracks.collection("popular") |> List.last  |> Map.get("title")

        assert first_blog_url == "California Girls"
        assert last_blog_url == "Drugs Feat Rosie Lowe"
      end
    end
  end

  describe "subcollection" do
    it "returns a tracks data as a subcollection" do
      use_cassette "tracks#subcollection" do
        first_track = Tracks.subcollection("2j9dg", "blogs") |> List.first
        last_track = Tracks.subcollection("2j9dg", "blogs") |> List.last

        assert first_track["sitename"] == "AFROPUNK - Sound Check"
        assert last_track["sitename"] == "PressPLAY"
      end
    end
  end

  describe "obtain" do
    it "finds a track by its id" do
      use_cassette "tracks#obtain" do
        followers = Tracks.obtain("2j9dg") |> Map.get("time")
        assert followers == 209
      end
    end
  end
end
