//
//  DVDCoreDataStack.h


#import <Foundation/Foundation.h>
@class NSManagedObjectContext;
@class NSFetchRequest;

@interface DVDCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;



//nosotros vamos a usar esta sencilla que guarda en la sanbox un documento con el mismo nombre Everpobre

+(DVDCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;


//existen estas otras
+(DVDCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                databaseFilename:(NSString*) aDBName;


+(DVDCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                    databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;



//metodo para cepillarse todos los datos

-(void) zapAllData;


//metodo para guardar (existe uno que es save: pero da errores...)
//en este usamos un metodo que acepta un bloque por si la caga

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

-(NSArray *)executeRequest:(NSFetchRequest *)request
                 withError:(void(^)(NSError *error))errorBlock;
-(void) deleteObject:(id)object;
@end
