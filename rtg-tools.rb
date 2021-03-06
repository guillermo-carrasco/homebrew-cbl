require 'formula'

class RtgTools < Formula
  homepage "http://realtimegenomics.com/products/rtg-tools/"
  version "3.5"

  url "https://github.com/RealTimeGenomics/rtg-tools/releases/download/3.5/rtg-tools-3.5-nojre.zip"
  sha1 "2959d41ce8e3edad46819592452e35390af1783c"

  def install
    java = share / 'java'
    java.install 'RTG.jar'
    doc.install 'RTGOperationsManual.pdf'
# The new open source release doesn't include a LICENSE.txt in the binary
# Although on reflection it probably should. Will address in the next point release.
#    prefix.install 'LICENSE.txt'
    prefix.install 'README.txt'
    prefix.install 'ReleaseNotes.txt'
    prefix.install 'rtg'
    prefix.install 'third-party'
    open(prefix / 'rtg.cfg', 'w') do |file|
      file.write <<-EOS.undent
        RTG_TALKBACK=     # Attempt to send crash logs to realtime genomics, true to enable
        RTG_USAGE=        # Enable simple usage logging, true to enable
        RTG_JAVA_OPTS=    # Additional arguments passed to the JVM
        RTG_JAR=#{java}/RTG.jar
      EOS
    end
    bin.install_symlink prefix / 'rtg'
  end

  test do
    system 'rtg'
  end
end
