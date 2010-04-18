import Directory
import Control.Monad
import System.IO
import List
import Control.Applicative
-- import qualified Data.ByteString.Lazy.Char8 as L
import qualified Data.ByteString.Char8 as L
-- import Data.Word
main = do
  entries <- getDirectoryContents "yeast"
  mapM_ (\x -> -- hPutStrLn stderr x >> 
               L.readFile x >>= (return . process) >>= persist)
    $ map ("yeast/" ++) $ (filter (".fna" `isSuffixOf`) entries)

persist :: L.ByteString -> IO ()
persist s = L.hPut stderr s

process :: L.ByteString -> L.ByteString
process str = L.unlines $ zipWith present [0..] 
              $ takeWhile (\x -> L.length x == 32) 
              $ map (L.take 32 . L.filter (/= '\n') . L.take 33  ) 
              $ L.tails $ L.drop 1 $ L.dropWhile (/= '\n') str

present :: Int -> L.ByteString -> L.ByteString
present offset chars = L.concat [L.pack ( show offset), L.pack " : ", chars]


-- GenomeIndexer git:(master): time ./indexer  2> hask        
-- ./indexer 2> hask  29.41s user 1.94s system 71% cpu 43.806 total

-- GenomeIndexer git:(master) : time ruby ./indexer.rb  2> ruby
-- ruby ./indexer.rb 2> ruby  182.92s user 156.27s system 94% cpu 6:00.76 total