require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class ElispSlimeNav < EmacsFormula
  desc "Slime-style navigation of Emacs Lisp"
  homepage "https://github.com/purcell/elisp-slime-nav"
  url "https://github.com/purcell/elisp-slime-nav/archive/0.8.tar.gz"
  sha256 "c9bd44cf8f4965e0470f6dc10c88fbc3ff0783274df865b5c9062bd0fdb2f556"
  head "https://github.com/purcell/elisp-slime-nav.git"

  depends_on :emacs

  def install
    byte_compile "elisp-slime-nav.el"
    elisp.install "elisp-slime-nav.el", "elisp-slime-nav.elc"
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{elisp}")
      (load "elisp-slime-nav")
      (turn-on-elisp-slime-nav-mode)
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
