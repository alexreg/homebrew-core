class Fcgene < Formula
  desc "Format-converting tool for genotype data"
  homepage "https://sourceforge.net/projects/fcgene/"
  url "https://downloads.sourceforge.net/project/fcgene/fcgene-1.0.7.tar.gz"
  sha256 "4e1f85f2ec812e2528bd19b6c18ecf297666cd83046e003bc57d9ed5f25783d6"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.ped").write(
      <<~EOF
        1 1000000000 0 0 1 1 0 0 1 1
        1 1000000001 0 0 1 2 1 1 1 2
      EOF
    )
    (testpath/"test.map").write(
      <<~EOF
        1 rs0 0 1000
        1 rs10 0 1001
      EOF
    )
    system "#{bin}/fcgene", "--ped", "test.ped", "--map", "test.map"
    assert_predicate testpath/"fcgene_out_fcgene.log", :exist?
  end
end
